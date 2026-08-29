# Dotfiles

A Nix flake configuring personal machines across NixOS, macOS, and WSL, where every feature is a dendritic aspect that hosts and users compose by inclusion.

## Language

### Core concepts

**Aspect**:
A named, reusable unit of configuration providing one feature. Hosts and users compose their systems by including aspects.
_Avoid_: module, feature, role

**Dendritic**:
The configuration pattern where every file is a flake module discovered automatically rather than wired up by hand, so one aspect file can configure the system and user layers together.
_Avoid_: modular, aspect-oriented

**Host**:
A machine the flake configures. Each host includes the aspects that exist on it and declares which users it has.
_Avoid_: machine, system

**User**:
A person's environment, composed from the aspects the user includes and instantiated on each host that declares them.
_Avoid_: account

**Hardware configuration**:
The auto-generated per-host file describing that machine's scanned hardware. Regenerated, never edited by hand.
_Avoid_: hardware scan

**Source override**:
A package from nixpkgs rebuilt from a newer upstream release by overriding its source.
_Avoid_: nightly, patched package

### AI

**Agent skills**:
Markdown skill definitions loaded into AI coding agents to guide how they work.
_Avoid_: agent tools, plugins

**Agent tools**:
CLI utilities installed for AI coding agents to shell out to.
_Avoid_: terminal tools, agent skills

**LLM agent aspect**:
The shared aspect inherited by AI coding-agent aspects whose packages come from llm-agents.nix.
_Avoid_: agent base, common agent config

### Nix

**Generation-retention policy**:
The shared host policy that preserves recent system, root, and user profile generations while removing older ones. Store garbage collection happens after generation retention and is not the policy itself.
_Avoid_: garbage-collection policy
