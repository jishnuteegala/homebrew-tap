class Stalelink < Formula
  desc "Find dead and outdated links in local documents"
  homepage "https://github.com/jishnuteegala/stalelink"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-aarch64-apple-darwin.tar.xz"
      sha256 "8eb49224af20ef9e972d6c63c1002e037fc8447edd60e33f4794a1195c69b70d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-x86_64-apple-darwin.tar.xz"
      sha256 "221fcb8ca0c99256bc6a056021e2f6a71e8649161341df6b570d10cf434f5758"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f9a0af1dd74dde3be34f29f7309439a261d5f36ee14c301721718a25ba95fb23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8989e32d5c54f566d835588d86ef790b7d90a2b9caa3de21dfd98348dbe05fe8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "stalelink"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "stalelink"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "stalelink"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "stalelink"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
