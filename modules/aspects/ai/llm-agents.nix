{ den, ... }: {

  # Nix packages for AI coding agents
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.llm-agents = {

    # Use binary cache (input must not follow system nixpkgs for this to work)
    os.nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
    os.nix.settings.extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];

    # Include agent skills and tools
    includes = with den.aspects; [ ai._.agent-skills ai._.agent-tools ];

  };

}
