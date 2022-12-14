require 'spec_helper'

describe Temple::Filters::ControlFlow do
  before do
    @filter = Temple::Filters::ControlFlow.new
  end

  it 'should process blocks' do
    expect(@filter.call([:block, 'loop do',
      [:static, 'Hello']
    ])).to eq [:multi,
                     [:code, 'loop do'],
                     [:static, 'Hello'],
                     [:code, 'end']]
  end

  it 'should process if' do
    expect(@filter.call([:if, 'condition',
      [:static, 'Hello']
    ])).to eq [:multi,
      [:code, 'if condition'],
      [:static, 'Hello'],
      [:code, 'end']
    ]
  end

  it 'should process if with else' do
    expect(@filter.call([:if, 'condition',
      [:static, 'True'],
      [:static, 'False']
    ])).to eq [:multi,
      [:code, 'if condition'],
      [:static, 'True'],
      [:code, 'else'],
      [:static, 'False'],
      [:code, 'end']
    ]
  end

  it 'should create elsif' do
    expect(@filter.call([:if, 'condition1',
      [:static, '1'],
      [:if, 'condition2',
       [:static, '2'],
       [:static, '3']]
    ])).to eq [:multi,
      [:code, 'if condition1'],
      [:static, '1'],
      [:code, 'elsif condition2'],
      [:static, '2'],
      [:code, 'else'],
      [:static, '3'],
      [:code, 'end']
    ]
  end

  it 'should process cond' do
    expect(@filter.call([:cond,
      ['cond1', [:exp1]],
      ['cond2', [:exp2]],
      [:else,   [:exp3]],
    ])).to eq [:multi,
      [:code, 'case'],
      [:code, 'when cond1'],
      [:exp1],
      [:code, 'when cond2'],
      [:exp2],
      [:code, 'else'],
      [:exp3],
      [:code, 'end']
    ]
  end

  it 'should process case' do
    expect(@filter.call([:case, 'var',
      ['Array',  [:exp1]],
      ['String', [:exp2]],
      [:else,    [:exp3]],
    ])).to eq [:multi,
      [:code, 'case (var)'],
      [:code, 'when Array'],
      [:exp1],
      [:code, 'when String'],
      [:exp2],
      [:code, 'else'],
      [:exp3],
      [:code, 'end']
    ]
  end
end
