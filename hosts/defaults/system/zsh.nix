# Options here are not marked mkDefault because you don't want to turn them off
# if the primary user's shell is zsh. To change them, its probably necessary to
# make a module or a top-level option called "useZsh" or something.
{pkgs, ...}: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = ["/share/zsh"];
}
