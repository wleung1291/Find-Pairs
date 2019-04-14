class Card
    attr_reader :size, :cardsArr, :emoji

    def initialize(n)
        @size = n * n
        @cardsArr = []
        @emoji = 
            ["😀", "💍", "👾", "👀", "💀", "😡", "👍", "👔", "🐶", "🐸", "🌸", 
            "🎃", "🌏", "🎄", "⭐️", "☀️", "🍇", "🍥", "🍎", "🍕", "🍣", "🍻", 
            "🍭", "🌶", "🍔", "🍜", "🏈", "🏀", "⚾", "🎯", "🏋", "🏓", "🎹", 
            "🏆", "🎭", "🎗", "🚀", "🚦", "🚔", "⛩", "🚒", "👿", "💩", "👻", 
            "🚥", "🚑", "💎", "🔫", "💊", "🎀", "🏳", "💁", "😱", "🦄", "🌈", 
            "🎁", "📀", "📸", "🔰", "💢", "💯", "🀄", "🎾", "🔑"]
    end
    
    # Creates a shuffled pair of cards array
    def cards_arr
        @emoji.shuffle!
        2.times {
            (0...@size/2).each do |i|
                @cardsArr << @emoji[i]
            end
        }
        return @cardsArr.shuffle
    end

end
