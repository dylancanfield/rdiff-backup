require 'spec_helper'

describe package('rdiff-backup') do
    it { should be_installed }
end

describe user('rdiff-backup-client') do
    it { should exist }
end
