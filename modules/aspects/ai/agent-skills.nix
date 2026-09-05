{ inputs, ... }: {

  # Anthropic example skills
  flake-file.inputs.anthropic-skills = {
    url = "github:anthropics/skills";
    flake = false;
  };

  # Agent skills for real engineering
  flake-file.inputs.mattpocock-skills = {
    url = "github:mattpocock/skills";
    flake = false;
  };

  # Rigorous agent workflows you can parallelise with confidence
  flake-file.inputs.cursor-plugins = {
    url = "github:cursor/plugins";
    flake = false;
  };

  # Lazy senior dev mode for AI agents
  flake-file.inputs.ponytail = {
    url = "github:DietrichGebert/ponytail";
    flake = false;
  };

  den.aspects.ai.provides.agent-skills.homeManager = { pkgs, ... }: let

    openaiExplicitInvocationPolicy = pkgs.writeText "openai-explicit-invocation-policy.yaml" ''
      policy:
        allow_implicit_invocation: false
    '';

    mkExplicit = source: let
      name = builtins.baseNameOf source;
    in "${pkgs.runCommandLocal "${name}-explicit-only" { } ''
      mkdir -p "$out"
      cp -r "${source}/." "$out/"
      chmod -R u+w "$out"

      head -n 1 "$out/SKILL.md" | grep -qx -- '---' || {
        echo "${name}: SKILL.md has unexpected frontmatter" >&2
        exit 1
      }

      awk '
        NR == 1 {
        print
        print "disable-model-invocation: true"
        frontmatter = 1
        next
        }
        frontmatter && /^disable-model-invocation:/ { next }
        frontmatter && /^---$/ { frontmatter = 0 }
        { print }
      ' "$out/SKILL.md" > "$out/SKILL.md.new"

      mv "$out/SKILL.md.new" "$out/SKILL.md"

      if [[ -e "$out/agents/openai.yaml" ]]; then
        echo "${name}: agents/openai.yaml already exists upstream" >&2
        exit 1
      fi

      install -Dm644 ${openaiExplicitInvocationPolicy} "$out/agents/openai.yaml"
    ''}";

    mkImplicit = source: let
      name = builtins.baseNameOf source;
    in "${pkgs.runCommandLocal "${name}-implicit" { } ''
      mkdir -p "$out"
      cp -r "${source}/." "$out/"
      chmod -R u+w "$out"

      head -n 1 "$out/SKILL.md" | grep -qx -- '---' || {
        echo "${name}: SKILL.md has unexpected frontmatter" >&2
        exit 1
      }

      awk '
        NR == 1 {
        print
        frontmatter = 1
        next
        }
        frontmatter && /^disable-model-invocation:/ { next }
        frontmatter && /^---$/ { frontmatter = 0 }
        { print }
      ' "$out/SKILL.md" > "$out/SKILL.md.new"

      mv "$out/SKILL.md.new" "$out/SKILL.md"
      rm -f "$out/agents/openai.yaml"
    ''}";

  in {

    _module.args.agentSkills = {

      # Anthropic skills
      frontend-design = "${inputs.anthropic-skills}/skills/frontend-design";

      # Matt Pocock's skills
      ask-matt = "${inputs.mattpocock-skills}/skills/engineering/ask-matt";
      code-review = "${inputs.mattpocock-skills}/skills/engineering/code-review";
      codebase-design = "${inputs.mattpocock-skills}/skills/engineering/codebase-design";
      diagnosing-bugs = "${inputs.mattpocock-skills}/skills/engineering/diagnosing-bugs";
      domain-modeling = "${inputs.mattpocock-skills}/skills/engineering/domain-modeling";
      grill-me = "${inputs.mattpocock-skills}/skills/productivity/grill-me";
      grill-with-docs = "${inputs.mattpocock-skills}/skills/engineering/grill-with-docs";
      grilling = "${inputs.mattpocock-skills}/skills/productivity/grilling";
      handoff = "${inputs.mattpocock-skills}/skills/productivity/handoff";
      implement = "${inputs.mattpocock-skills}/skills/engineering/implement";
      improve-codebase-architecture = "${inputs.mattpocock-skills}/skills/engineering/improve-codebase-architecture";
      prototype = "${inputs.mattpocock-skills}/skills/engineering/prototype";
      research = "${inputs.mattpocock-skills}/skills/engineering/research";
      resolving-merge-conflicts = "${inputs.mattpocock-skills}/skills/engineering/resolving-merge-conflicts";
      setup-matt-pocock-skills = "${inputs.mattpocock-skills}/skills/engineering/setup-matt-pocock-skills";
      tdd = "${inputs.mattpocock-skills}/skills/engineering/tdd";
      teach = "${inputs.mattpocock-skills}/skills/productivity/teach";
      to-questionnaire = "${inputs.mattpocock-skills}/skills/productivity/to-questionnaire";
      to-spec = "${inputs.mattpocock-skills}/skills/engineering/to-spec";
      to-tickets = "${inputs.mattpocock-skills}/skills/engineering/to-tickets";
      triage = "${inputs.mattpocock-skills}/skills/engineering/triage";
      wait-what = "${inputs.mattpocock-skills}/skills/productivity/wait-what";
      wayfinder = "${inputs.mattpocock-skills}/skills/engineering/wayfinder";
      wizard = "${inputs.mattpocock-skills}/skills/engineering/wizard";
      writing-for-agents = "${inputs.mattpocock-skills}/skills/productivity/writing-for-agents";

      # Lauren Tan's skills
      unslop = mkImplicit "${inputs.cursor-plugins}/pstack/skills/unslop";

      # Ponytail skills
      ponytail = mkExplicit "${inputs.ponytail}/skills/ponytail";
      ponytail-audit = mkExplicit "${inputs.ponytail}/skills/ponytail-audit";
      ponytail-review = mkExplicit "${inputs.ponytail}/skills/ponytail-review";

    };

  };

}
