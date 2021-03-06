# frozen_string_literal: true

RSpec.describe "teletype new --license", type: :sandbox do
  it "generates a MIT license file" do
    app_name = "newcli"
    command = "teletype new #{app_name} --license mit --author 'Piotr Murach'"
    `#{command}`

    license = File.binread("newcli/LICENSE.txt")
    gemspec = File.binread("newcli/newcli.gemspec")
    readme  = File.binread("newcli/README.md")

    expect(license.lines[0]).to eq("The MIT License (MIT)\n")
    expect(gemspec).to match(/spec.license\s{7}= "MIT"/)
    expect(readme).to include "Copyright (c) #{Time.now.year} Piotr Murach. See [MIT License](LICENSE.txt) for further details."
  end

  it "generates a GPL-3.0 license file" do
    app_name = "newcli"
    command = "teletype new #{app_name} -l gplv3 -a 'Piotr Murach'"
    `#{command}`

    license = File.binread("newcli/LICENSE.txt")
    gemspec = File.binread("newcli/newcli.gemspec")
    readme  = File.binread("newcli/README.md")

    expect(license.lines[0]).to eq("GNU GENERAL PUBLIC LICENSE\n")
    expect(gemspec).to match(/spec.license\s{7}= "GPL-3.0"/)
    expect(readme).to include "Copyright (c) #{Time.now.year} Piotr Murach. See [GNU General Public License v3.0](LICENSE.txt) for further details."
  end

  it "fails to recognise the license type" do
    app_name = "newcli"
    command = "teletype new #{app_name} --license unknown"
    out, err, process = Open3.capture3(command)

    expect(out).to eq("")
    expect(err).to eq("Expected '--license' to be one of agplv3, apache, bsd2, bsd3, gplv2, gplv3, lgplv3, mit, mplv2, custom; got unknown\n")
    expect(process.exitstatus).to eq(1)
  end
end
