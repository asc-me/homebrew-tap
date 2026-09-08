# `gban` — the Graphban client for a human at a terminal.
#
# NO `resource` STANZAS, and that is a property of the package rather than an omission.
# `graphban-cli` declares no runtime dependencies at all — its HTTP client is
# `urllib.request` from the standard library — so there is nothing to vendor and nothing to
# regenerate when a transitive dependency moves. A Python formula normally carries one
# `resource` per transitive dependency and rots the moment any of them is bumped.
class Gban < Formula
  include Language::Python::Virtualenv

  desc "Graphban client for the human at a terminal"
  homepage "https://github.com/asc-me/graphban"
  url "https://files.pythonhosted.org/packages/1b/02/91627442ed2cc1b2e080457b9c04ae07f019656203745a60984d271d8f0e/graphban_cli-0.1.0.tar.gz"
  sha256 "19cd1598b1dffeebba1aba33fb8978a1636f5fbd35692b9692eb274fb75f9de1"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # Two claims, and the second is the one worth making. `--help` proves the entry point
    # resolves; `whoami` against a server that does not exist proves the binary RUNS — it
    # reaches the network layer and fails there, rather than dying on an import.
    assert_match "the human at a terminal", shell_output("#{bin}/gban --help")
    output = shell_output("#{bin}/gban --server http://127.0.0.1:1 whoami 2>&1", 3)
    assert_match(/could not reach|session expired/, output)
  end
end
