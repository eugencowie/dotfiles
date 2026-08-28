# Dotfiles

Nix configurations for my machines (NixOS, Darwin, WSL), organised as dendritic aspects.

## Language

**Agent skills**:
Markdown skill definitions loaded into AI coding agents to guide how they work.
_Avoid_: agent tools, plugins

**Agent tools**:
CLI utilities (ripgrep, fd, jq, tree, bat, fzf) installed for AI coding agents to shell out to.
_Avoid_: terminal tools, agent skills

**LLM agent aspect**:
The shared environment inherited by AI coding-agent aspects whose packages come from llm-agents.nix.
_Avoid_: agent base, common agent config

**Generation-retention policy**:
The shared host policy that preserves recent system, root, and user profile generations while removing older ones. Store garbage collection happens after generation retention and is not the policy itself.
_Avoid_: garbage-collection policy
