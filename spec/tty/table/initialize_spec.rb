# -*- encoding: utf-8 -*-

require 'spec_helper'

describe TTY::Table, '#initialize' do
  let(:header) { ['Header1', 'Header2'] }
  let(:rows)   { [['a1', 'a2'], ['b1', 'b2']] }

  it { should be_kind_of(Enumerable) }

  it { should be_kind_of(Comparable) }

  it { (Enumerable === subject).should be_true }

  it 'initializes table header' do
    table = TTY::Table.new :header => header
    table.header.should == header
  end

  it 'initializes table header as an option' do
    table = TTY::Table.new :header => header
    table.header.should == header
  end

  it 'initializes with rows as arguments' do
    table = TTY::Table[*rows]
    table.to_a.should == rows
  end

  it 'initializes ' do
    table = TTY::Table.new rows
    table.to_a.should == rows
  end

  it 'initializes table rows as an option' do
    table = TTY::Table.new :rows => rows
    table.to_a.should == rows
  end

  it 'initializes table rows as an argument' do
    table = TTY::Table.new header, rows
    table.to_a.should == rows
  end

  it 'initializes table rows in a block with param' do
    table = TTY::Table.new  do |t|
      t << rows[0]
      t << rows[1]
    end
    table.to_a.should == rows
  end

  it 'initializes table and adds rows' do
    table = TTY::Table.new
    table << rows[0]
    table << rows[1]
    table.to_a.should == rows
  end

  it 'converts row arguments from hash to array' do
    table = TTY::Table.new :rows => {:a => 1, :b => 2}
    table.to_a.should include [:a, 1 ]
  end
end