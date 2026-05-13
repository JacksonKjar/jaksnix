{ ... }:
{
  flake.templates = {
    default = {
      path = ../templates/default;
      description = "Basic development environment with direnv";
    };
    python = {
      path = ../templates/python;
      description = "Python development environment with uv";
    };
    typescript = {
      path = ../templates/typescript;
      description = "TypeScript development environment";
    };
    kotlin = {
      path = ../templates/kotlin;
      description = "Kotlin development environment with Gradle";
    };
  };
}
