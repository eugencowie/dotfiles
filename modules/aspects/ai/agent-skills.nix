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

  den.aspects.ai.provides.agent-skills.homeManager = { lib, pkgs, ... }: let

    # Patch a skill to allow/disallow implicit model invocation
    mkInvocation = mode: source: let
      explicit = mode == "explicit";
      implicit = mode == "implicit";
    in assert explicit || implicit; pkgs.applyPatches {
      name = "${baseNameOf source}-${mode}";
      src = source;
      nativeBuildInputs = with pkgs; [ yq-go ];
      postPatch = with lib; ''
        mkdir -p agents && touch agents/openai.yaml
        yq -i '.policy.allow_implicit_invocation = ${boolToString implicit}' agents/openai.yaml
        yq --front-matter=process -i '.disable-model-invocation = ${boolToString explicit}' SKILL.md
      '';
    };

    # Patch a skill to require explicit user invocation
    mkExplicit = mkInvocation "explicit";

    # Patch a skill to allow implicit model invocation
    mkImplicit = mkInvocation "implicit";

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
      principle-boundary-discipline = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-boundary-discipline";
      principle-fix-root-causes = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-fix-root-causes";
      principle-guard-the-context-window = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-guard-the-context-window";
      principle-laziness-protocol = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-laziness-protocol";
      principle-migrate-callers-then-delete-legacy-apis = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-migrate-callers-then-delete-legacy-apis";
      principle-minimize-reader-load = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-minimize-reader-load";
      principle-model-the-domain = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-model-the-domain";
      principle-outcome-oriented-execution = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-outcome-oriented-execution";
      principle-prove-it-works = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-prove-it-works";
      principle-redesign-from-first-principles = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-redesign-from-first-principles";
      principle-sequence-verifiable-units = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-sequence-verifiable-units";
      principle-subtract-before-you-add = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-subtract-before-you-add";
      principle-type-system-discipline = mkImplicit "${inputs.cursor-plugins}/pstack/skills/principle-type-system-discipline";
      typescript-best-practices = mkImplicit "${inputs.cursor-plugins}/pstack/skills/typescript-best-practices";
      unslop = mkExplicit "${inputs.cursor-plugins}/pstack/skills/unslop";

      # Cursor skills
      thermo-nuclear-code-quality-review = mkExplicit "${inputs.cursor-plugins}/thermos/skills/thermo-nuclear-code-quality-review";

      # Ponytail skills
      ponytail = mkExplicit "${inputs.ponytail}/skills/ponytail";
      ponytail-audit = mkExplicit "${inputs.ponytail}/skills/ponytail-audit";
      ponytail-review = mkExplicit "${inputs.ponytail}/skills/ponytail-review";

    };

  };

}
