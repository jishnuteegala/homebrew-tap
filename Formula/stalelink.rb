class Stalelink < Formula
  desc "Find dead and outdated links in local documents"
  homepage "https://github.com/jishnuteegala/stalelink"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-aarch64-apple-darwin.tar.xz"
      sha256 "dfddec03a8736dbdbab62afd6782bea9524abcb86ac75c5475409a54f7c2b46f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-x86_64-apple-darwin.tar.xz"
      sha256 "1b1aca7b4e75894ade1ebbb81f6d3b23cc9f357238344db556aa6daebeb390fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "323252a41ae4fd39e81b9713b11fdeb1df9b271d713f8e96647afa15c2836c0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jishnuteegala/stalelink/releases/download/v0.1.0/stalelink-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d6052ae494be09da5c46f0030f53eb70f0693855d1773e4ce28329586f9a540"
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
