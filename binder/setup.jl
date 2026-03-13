# This script runs during the Binder build phase.
# It installs Julia packages and pre-compiles OITOOLS so the first notebook
# cell loads in ~5 seconds rather than ~5 minutes.

import Pkg
Pkg.activate("..")

# Point PyCall at the conda Python Binder created from environment.yml
# This is the fix for the CXXABI ABI mismatch issue.
ENV["PYTHON"] = "/opt/conda/bin/python"
Pkg.build("PyCall")

Pkg.Registry.add("General")
try
    Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/emmt/EmmtRegistry"))
catch e
    @warn "EmmtRegistry not added: $e"
end

Pkg.instantiate()

# Pre-compile
@info "Pre-compiling OITOOLS (this takes a few minutes)..."
using OITOOLS
using PyCall
using PyPlot
@info "Pre-compilation complete."
