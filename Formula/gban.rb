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
  url "https://files.pythonhosted.org/packages/2b/e4/d306b4dbb0d5010c7ae5584b3388318ede9ff85a5732b2331068e7b40f1e/graphban_cli-0.8.9.tar.gz"
  sha256 "18131e6882d634ff5e108755784faacc7d697a78c6b29dc2f9e3aaecf96cc97e"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # A SHORT phrase, deliberately. argparse re-wraps the description to the terminal width,
    # so a long assertion passes at one width and fails at another — and the first version of
    # this test asserted "the human at a terminal" against help text that says "for a human",
    # which is the other way to get this wrong.
    assert_match "Graphban client", shell_output("#{bin}/gban --help")

    # Exit 3 is `gban`'s no-session code. It proves the binary STARTS: it resolved its entry
    # point, read its config directory and reported the absence in its own words, rather than
    # dying on an import or a missing module. It does NOT reach the network — the session
    # check comes first — so the unreachable address here is only a guarantee that nothing
    # this test does can touch a real server.
    output = shell_output("#{bin}/gban --server http://127.0.0.1:1 whoami 2>&1", 3)
    assert_match "gban login", output
  end
end
