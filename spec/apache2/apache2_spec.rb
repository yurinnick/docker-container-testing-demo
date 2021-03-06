require 'spec_helper'

describe package('apache2') do
  it { should be_installed }
end

describe process('apache2') do
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end
