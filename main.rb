require_relative 'user.rb'
require_relative 'deck.rb'
require_relative 'card.rb'

class Main
  attr_accessor :cards, :deck, :hand, :user, :coin

  def initialize
    @deck = Deck.new
    puts 'Введите свое имя: '
    @name = gets.chomp.capitalize
    puts "Добро пожаловать в игру #{@name}"
    @player = User.new(@name)
    @dealer = User.new('Dealer')
    start_game
  end

  def start_game
    2.times { add_card(@player) }
    2.times { add_card(@dealer) }
    @player.rate
    @dealer.rate
    puts "#{@name} Ваши карты #{@player.hand[0].rank} #{@player.hand[0].suit} #{@player.hand[1].rank}#{@player.hand[1].suit} осталось#{@player.coin}$ сумма карт #{summa(@player)} "
    puts "#{see_dealer} и осталось #{@dealer.coin}$"
    menu
    end
  end

def menu
  puts '1 - Взять одну карту  2 - Пропустить ход  3 - Открыться  '
  input = gets.to_i
  case input
  when 1 then player_give
  when 2 then dealer_give
  when 3 then show_card_player
  when 0 then exit
  end
end

def show_card_player
  puts "#{@name} Ваши карты #{@player.hand[0].rank} #{@player.hand[0].suit} #{@player.hand[1].rank} #{@player.hand[1].suit} сумма #{summa(@player)}"
  puts "Карты дилера #{@dealer.hand[0].rank} #{@dealer.hand[0].suit} #{@player.hand[1].rank}#{@dealer.hand[1].suit} сумма #{summa(@dealer)}"
  if summa(@dealer) > summa(@player) && summa(@dealer) < 21
    @dealer.winnings
    puts "Вы проиграли, Выйграл диллер. У диллера #{@dealer.coin}$, у тебя #{@player.coin}$"
    new_game
  elsif summa(@player) > summa(@dealer) && summa(@player) < 21
    puts "Вы выиграли, у диллера #{summa(@dealer)} очков"
    @player.winnings
    new_game
  else
    @player.winn
    @dealer.winn
    puts 'Ничья'
    new_game
   end
end

def summa(user)
  user.count_values
end

def add_card(user)
  user.deal
end

def see_card
  @player.show_card
end

def see_dealer
  "У дилера #{@dealer.show_dealer} карты"
end

def player_give
  add_card(@player)
  puts "Вы взяли карту #{@player.hand[2].rank}#{@player.hand[2].suit}, сумма карт стала #{summa(@player)} "
  dealer_give
  if summa(@player) <= 21 && summa(@player) > summa(@dealer)
    puts "У диллера #{summa(@dealer)} очков"
    @player.winnings
    puts "Вы победили.Сумма ваших карт #{summa(@player)} У Вас #{@player.coin}$"
  end
  new_game
end

def dealer_give
  while summa(@dealer) <= 17
    add_card(@dealer)
    puts "Дилер взял карту #{@dealer.hand[2].rank}#{@dealer.hand[2].suit} "
    puts "У диллера #{@dealer.hand[0].rank}#{@dealer.hand[0].suit} #{@dealer.hand[1].rank}#{@dealer.hand[1].suit} #{@dealer.hand[2].rank}#{@dealer.hand[2].suit}сумма карт #{summa(@dealer)}"
    if summa(@dealer) > summa(@player) && summa(@dealer) < 21
      @dealer.winnings
      puts "Вы проиграли, Выйграл диллер. У диллера #{@dealer.coin}$, у тебя #{@player.coin}$"
      new_game
    else @player.winnings
         puts "Вы выиграли, у диллера #{summa(@dealer)}очков"
         new_game
    end
    if summa(@dealer) == 21
      puts "У диллера #{@dealer.hand[0].rank}#{@dealer.hand[0].suit} #{@dealer.hand[1].rank}#{@dealer.hand[1].suit}"
      @dealer.winnings
      puts "Диллер выйграл сумма карт #{summa(@dealer)} У диллера #{@dealer.coin}$ у тебя #{@player.coin}$"
      new_game
    elsif summa(@dealer) > 21
      puts "У диллера #{@dealer.hand[0].rank}#{@dealer.hand[0].suit} #{@dealer.hand[1].rank}#{@dealer.hand[1].suit}"
      @player.winnings
      puts "У диллера больше 21, ты победил. У тебя #{@player.coin}$"
      new_game
    end
end
end

def new_game
  puts 'Вы желаете сыграть еще раз?'
  puts '1- да  2- нет '
  input = gets.to_i
  case input
  when 1 then
    until @player.zero? && @dealer.zero?
      @player.reset_cards
      @dealer.reset_cards
      start_game
      if @player.zero?
        exit puts 'У вас не хватает денег для игры'
      elsif @dealer.zero?
        exit puts 'У Диллера нехватает денег для игры'
      end
    end
  when 2 then
    puts 'Спасибо за игру'
    abort
  end
end

run = Main.new.start
