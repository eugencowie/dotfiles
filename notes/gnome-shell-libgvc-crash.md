# GNOME autologin session crash: PipeWire and libgvc

Date investigated: 2026-08-04

## Summary

GDM autologin is working. The apparent autologin failure is a GNOME Shell
crash during audio discovery:

1. GDM opens a Wayland session for `echo`.
2. GNOME Shell connects to PipeWire's PulseAudio compatibility service.
3. PipeWire exposes a transient card state with ports but no complete card
   profiles or active profile.
4. GNOME Shell's bundled libgnome-volume-control (`libgvc`) dereferences the
   null `pa_card_info.active_profile` pointer.
5. GNOME Shell exits and GDM falls back to the greeter.

The safest targeted solution is to patch GNOME Shell's bundled libgvc to
handle a null active profile. Disabling the two GPU HDMI audio controllers is
the next-best workaround if HDMI/DisplayPort audio is not needed. A
startup-ordering delay may reduce the race frequency, but is not a correctness
fix.

## Local evidence

The 2026-08-04 13:14 boot produced this sequence:

```text
13:14:17 gdm-autologin: session opened for user echo
13:14:18 gnome-shell: Running GNOME Shell
13:14:19 pipewire-pulse: card 56 port 0 profiles inconsistent (0 < 2)
13:14:19 kernel: gnome-shell segfault in libgvc.so+0xd8f4
13:14:20 systemd: org.gnome.Shell@user.service failed (core-dump)
13:14:31 gdm-autologin: session closed for user echo
13:14:31 logind: new gdm-greeter session
```

The core backtrace starts in
`_pa_context_get_card_info_by_index_cb`. Disassembly maps the exact fault to:

```asm
mov 0x30(%r10), %rax  # pa_card_info.active_profile
mov (%rax), %rsi      # dereference active_profile->name; %rax is NULL
```

That corresponds to the unconditional call below in the libgvc revision
bundled by GNOME Shell 50.2:

```c
gvc_mixer_card_set_profile (card, info->active_profile->name);
```

The source is visible in the
[pinned libgvc revision](https://gitlab.gnome.org/GNOME/libgnome-volume-control/-/blob/0a4eda0cdc2deb352bebc70ec697c42af46094e4/gvc-mixer-control.c#L2590-2650).
The same unchecked dereference is still present on libgvc `master` as of this
investigation.

This signature also occurred on 2026-07-25, before the latest `flake.lock`
update, and one boot of the updated generation completed autologin normally.
The lock update may affect timing, but it did not introduce the underlying
defect.

The problematic hardware is very likely the two GPU HDMI/DisplayPort audio
controllers: the failures alternate between four- and five-port cards, which
matches the multi-port GPU devices. The local ALSA controllers are:

| ALSA card | PCI address | Codec |
| --- | --- | --- |
| `card0` | `0000:01:00.1` | NVIDIA GPU HDMI/DP |
| `card1` | `0000:0c:00.1` | AMD/ATI HDMI |
| `card2` | `0000:0c:00.6` | Realtek ALC897 analog audio |

The device attribution is an inference from port counts; the crash log contains
the PipeWire object index rather than its device name.

## Upstream evidence

PipeWire already recognizes this class of inconsistent topology. Its
[MR 541](https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/541)
added the exact `profiles inconsistent` diagnostic and truncates a port's
profile array when the card and port profile data are out of sync. The merge
request explicitly notes that malformed card data can crash libpulse clients,
including GNOME Shell. The related
[PipeWire issue 774](https://gitlab.freedesktop.org/pipewire/pipewire/-/work_items/774)
contains an older GNOME Shell/libpulse crash caused by inconsistent card data.

PipeWire 1.6.8 still sends the card record when the complete profile list is
empty. The source serializes `card_info.active_profile_name`, which becomes a
null active-profile pointer in libpulse; see
[PipeWire 1.6.8's card serialization](https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/1.6.8/src/modules/module-protocol-pulse/pulse-server.c#L3590-3698).
The consistency guard remains unchanged on PipeWire `master`, and no later
commit touching the Pulse server fixes this exact state as of 2026-08-04.

libpulse zero-initializes `pa_card_info` and only assigns `active_profile` when
the active-profile name matches one of the returned profiles; with zero
profiles it remains null. See
[libpulse's card-info parser](https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/master/src/pulse/introspect.c#L928-993).
Its public structure also explicitly permits the newer `active_profile2`
pointer to be null; see
[`pa_card_info`](https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/master/src/pulse/introspect.h#L601-619).
Regardless of which side should suppress the transient card state, a desktop
process should not unconditionally dereference this pointer.

Recent libgvc work confirms that PipeWire can expose transient audio topology
that older libgvc assumptions do not tolerate. For example,
[libgvc MR 31](https://gitlab.gnome.org/GNOME/libgnome-volume-control/-/merge_requests/31)
made portless streams non-fatal for PipeWire 1.5.84 and newer. That merged fix
is already older than the libgvc revision bundled here, but it addresses a
different assertion and does not guard `pa_card_info.active_profile`.

## Tracking upstream

There is no open upstream issue or merge request for this exact current crash
as of 2026-08-04. The exact historical precedent is
[PipeWire issue 393](https://gitlab.freedesktop.org/pipewire/pipewire/-/work_items/393):
it reports intermittent GNOME Shell or GDM startup crashes in libgvc's
`update_card` callback with PipeWire-Pulse, HDMI audio, and multiple monitors.
PipeWire closed that issue in 2020 after changing its startup synchronization
to [wait for the initial sync](https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/cc7f91db193925ae8d9436f07d9076b51e5616cb)
and [publish object updates only after a consistent sync](https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/a65d4d04c3c9449c484e5b1e1a06dad2cbfa7c7c).
Its closed status therefore cannot track whether the present regression is
fixed.

PipeWire also briefly addressed issue 393 by
[synthesizing an active `off` profile when a card had no profiles](https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/55982c75dbdc704c1369a3dc7a16063a283ba8b6),
but [removed that fallback a week later](https://gitlab.freedesktop.org/pipewire/pipewire/-/commit/ea84177a2e2224d6eb993b99401425849598ef3c).
That history, together with the current `profiles inconsistent` diagnostic,
makes the present behavior a strong candidate for a PipeWire regression of
issue 393. The newer PipeWire issue 774 and MR 541 are related inconsistent
topology bugs, but have a different device-removal/libpulse failure and are
also closed.

The best removal tracker would be a new PipeWire issue titled
[`pulse-server: transient card with no profiles crashes GNOME Shell at startup`](https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/new?issue%5Btitle%5D=pulse-server%3A%20transient%20card%20with%20no%20profiles%20crashes%20GNOME%20Shell%20at%20startup),
filed as a regression of issue 393 and cross-linked to MR 541. The GPU-audio
workaround should only be removed after that issue identifies a released fix,
or after libgvc independently merges a null-`active_profile` guard and GNOME
Shell updates its bundled libgvc revision.

## Candidate solutions

### 1. Patch libgvc to tolerate a null active profile — recommended

Guard both existing dereferences in `update_card`:

```c
is_default = (info->active_profile != NULL &&
              g_strcmp0 (pi.name, info->active_profile->name) == 0);

if (info->active_profile != NULL)
        gvc_mixer_card_set_profile (card, info->active_profile->name);
```

This preserves all available card information without inventing a current
profile. When WirePlumber finishes constructing the profiles, a later card
update can set it normally. The degradation is a temporarily unset profile
rather than loss of the entire desktop session.

The GNOME Shell release archive contains
`subprojects/gvc/gvc-mixer-control.c`, so Nixpkgs can apply a normal patch via
an overlay:

```nix
nixpkgs.overlays = [
  (_final: prev: {
    gnome-shell = prev.gnome-shell.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./patches/gnome-shell-gvc-null-active-profile.patch
      ];
    });
  })
];
```

An independently maintained NixOS configuration carries
[this exact patch](https://github.com/matteo-pacini/nixos-configs/blob/744bef050676baa770a00eb1be49a0c8af78a32c/patches/gnome-shell/001-gvc-null-active-profile.patch)
for the same GNOME Shell 50.2 callback, PipeWire warning, and GDM autologin
failure. That is corroborating field evidence, not an upstream fix.

Advantages:

- Fixes the proven null dereference directly.
- Preserves all audio controllers.
- Does not depend on startup timing.

Trade-offs:

- Rebuilds GNOME Shell locally.
- Carries a downstream patch until upstream accepts an equivalent fix.
- Other programs that bundle libgvc separately are not protected, although
  GNOME Shell is the component breaking autologin here.

GNOME Settings Daemon and GNOME Control Center also vendor libgvc and could be
patched for consistency. They are not required to restore autologin: Control
Center is not running at login, and a media-keys service crash does not take
down the compositor and session.

### 2. Disable GPU HDMI/DisplayPort audio in WirePlumber

If this machine does not use monitor audio, disable the two inferred offending
controllers while retaining the Realtek analog controller:

```nix
services.pipewire.wireplumber.extraConfig."51-disable-gpu-audio" = {
  "monitor.alsa.rules" = [
    {
      matches = [
        { "device.name" = "alsa_card.pci-0000_01_00.1"; }
        { "device.name" = "alsa_card.pci-0000_0c_00.1"; }
      ];
      actions.update-props."device.disabled" = true;
    }
  ];
};
```

WirePlumber documents ALSA device matching and property updates in its
[ALSA configuration reference](https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/alsa.html).
NixOS exposes configuration fragments through
[`services.pipewire.wireplumber.extraConfig`](https://github.com/NixOS/nixpkgs/blob/643809054d65fdd466a63e3155b8c498cb483c04/nixos/modules/services/desktops/pipewire/wireplumber.nix#L74-L119).

Advantages:

- Avoids a custom GNOME build.
- Removes the devices most likely producing incomplete multi-port topology.

Trade-offs:

- Disables HDMI/DisplayPort audio on both GPUs.
- Device attribution should ideally be confirmed with verbose PipeWire logs.
- It treats the trigger, not the unsafe client behavior.

### 3. Start audio first and delay GNOME Shell — low-confidence workaround

The installed `org.gnome.Shell@.service` has no dependency on PipeWire or
WirePlumber. `pipewire-pulse.service` and `wireplumber.service` are
`Type=simple`, so even systemd ordering only guarantees that the processes have
started, not that audio-card policy is fully populated.

A NixOS user-unit drop-in can start both services first and add a short grace
period:

```nix
systemd.user.services."org.gnome.Shell@" = {
  overrideStrategy = "asDropin";
  wants = [ "pipewire-pulse.service" "wireplumber.service" ];
  after = [ "pipewire-pulse.service" "wireplumber.service" ];
  serviceConfig.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
};
```

Advantages:

- Small configuration-only change.
- Matches the observed race: successful boots gave WirePlumber longer to
  populate profiles; failed boots queried almost immediately after startup.

Trade-offs:

- Timing-based rather than a correctness fix.
- Adds two seconds to graphical login, including the greeter.
- May regress on slower boots or different hardware.

A readiness probe would be stronger than a fixed delay, but it needs careful
testing: merely connecting with `pactl` can itself activate the Pulse server,
and an empty card list must not be mistaken for readiness.

### 4. Replace PipeWire-Pulse with PulseAudio — broad fallback

Disabling `services.pipewire` and enabling `services.pulseaudio` would remove
PipeWire's PulseAudio compatibility layer from this path. This is likely to
avoid this particular topology race because libgvc was originally designed
against PulseAudio, but it is a high-impact subsystem change and may affect
Sunshine, Bluetooth, application routing, and existing audio state.

Use only if the targeted patch and startup workaround fail.

### Not recommended: rollback or blind package upgrade

- The identical crash occurred before the latest lock update.
- Both the previous and current generations use GNOME Shell 50.2 and PipeWire
  1.6.8.
- Current libgvc and PipeWire master branches do not contain a fix for this
  exact null active-profile path.

A rollback may change timing and appear to help, but it does not remove the
defect. An upgrade should only be preferred once an upstream commit explicitly
guards this state or suppresses incomplete card records.

## Recommended implementation and verification

Implement solution 1 first. If avoiding a local GNOME Shell build matters more
than retaining GPU audio, use solution 2. Treat solution 3 only as a temporary
experiment because it changes timing rather than fixing the invalid
assumption.

Verification should include:

1. Run `mise run check`.
2. Apply the configuration with `mise run apply`.
3. Reboot several times because the trigger is timing-sensitive.
4. On each boot, confirm that `echo` retains the Wayland seat:

   ```sh
   loginctl list-sessions
   ```

5. Confirm the known crash signature is absent:

   ```sh
   journalctl -b --no-pager |
     rg 'profiles inconsistent|segfault.*libgvc|org.gnome.Shell@user.service: Failed'
   ```

6. Confirm HDMI and analog audio behavior appropriate to the chosen solution.

No existing upstream issue found during this investigation describes the exact
`active_profile == NULL` startup crash on GNOME Shell 50.2. A useful upstream
report would include the journal sequence, coredump backtrace, disassembly/source
mapping, PipeWire/WirePlumber versions, and the dual-GPU ALSA inventory above.
