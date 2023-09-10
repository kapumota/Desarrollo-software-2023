# frozen_string_literal: true

require_relative '../lib/ruby_intro.rb'

describe 'Introduccion a Ruby' do
  describe '#sum' do
    it 'deberia ser definido' do
      expect { sum([1, 3, 4]) }.not_to raise_error
    end

    it 'retorna la suma correcta', points: 20 do
      expect(sum([1, 2, 3, 4, 5])).to be_a_kind_of Integer
      expect(sum([1, 2, 3, 4, 5])).to eq(15)
      expect(sum([1, 2, 3, 4, -5])).to eq(5)
      expect(sum([1, 2, 3, 4, -5, 5, -100])).to eq(-90)
    end

    it 'trabaja sobre el arreglo vacio', points: 10 do
      expect { sum([]) }.not_to raise_error
      expect(sum([])).to be_zero
    end
  end

  describe '#max_2_sum' do
    it 'deberia ser definido' do
      expect { max_2_sum([1, 2, 3]) }.not_to raise_error
    end
    it 'retorna la suma correcta', points: 7 do
      expect(max_2_sum([1, 2, 3, 4, 5])).to be_a_kind_of Integer
      expect(max_2_sum([1, -2, -3, -4, -5])).to eq(-1)
    end
    it 'trabaja incluso si los dos valores mas grandes son lo mismo', points: 3 do
      expect(max_2_sum([1, 2, 3, 3])).to eq(6)
    end
    it 'retorna cero si el arreglo es vacio', points: 10 do
      expect(max_2_sum([])).to be_zero
    end
    it 'retorna el valor del elemento si es solo un elemento', points: 10 do
      expect(max_2_sum([3])).to eq(3)
    end
  end

  describe '#sum_to_n' do
    it 'deberia ser definido' do
      expect { sum_to_n?([1, 2, 3], 4) }.not_to raise_error
    end
    it 'retorna verdadero cuando dos elementos cualesquiera se suman al segundo argumento', points: 30 do
      expect(sum_to_n?([1, 2, 3, 4, 5], 5)).to be true # 2 + 3 = 5
      expect(sum_to_n?([3, 0, 5], 5)).to be true # 0 + 5 = 5
      expect(sum_to_n?([-1, -2, 3, 4, 5, -8], -3)).to be true  # handles negative sum
      expect(sum_to_n?([-1, -2, 3, 4, 5, -8], 12)).to be false # 3 + 4 + 5 = 12 (not 3 elements)
      expect(sum_to_n?([-1, -2, 3, 4, 6, -8], 12)).to be false # no two elements that sum
    end
    it 'retorna falso para un unico elemento del arreglo', points: 5 do
      expect(sum_to_n?([0], 0)).to be false
      expect(sum_to_n?([1], 1)).to be false
      expect(sum_to_n?([-1], -1)).to be false
      expect(sum_to_n?([-3], 0)).to be false
    end
    it 'retorna falso para un arreglo vacior', points: 5 do
      expect(sum_to_n?([], 0)).to be false
      expect(sum_to_n?([], 7)).to be false
    end
  end
end
