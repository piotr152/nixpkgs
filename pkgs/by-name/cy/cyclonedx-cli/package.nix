{ lib
, buildDotnetModule
, fetchFromGitHub
, dotnetCorePackages
}:

buildDotnetModule rec {
  pname = "cyclonedx-cli";
  version = "0.25.1";

  src = fetchFromGitHub {
    owner = "CycloneDX";
    repo = "cyclonedx-cli";
    rev = "refs/tags/v${version}";
    hash = "sha256-9G9g4bfH6EGSTZQlaiLsRjnryl+mQ3uNXdBUBVcKwlg=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_6_0;
  nugetDeps = ./deps.nix;

  preFixup = ''
    cd $out/bin
    find . ! -name 'cyclonedx' -type f -exec rm -f {} +
  '';

  meta = with lib; {
    description = "CycloneDX CLI tool for SBOM analysis, merging, diffs and format conversions";
    homepage = "https://github.com/CycloneDX/cyclonedx-cli";
    changelog = "https://github.com/CycloneDX/cyclonedx-cli/releases/tag/v${version}";
    maintainers = with maintainers; [ thillux ];
    license = licenses.asl20;
    platforms = with platforms; (linux ++ darwin);
    mainProgram = "cyclonedx";
  };
}
