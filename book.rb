require 'rspec'
require 'faker'

class Bookstore
  attr_reader :books

  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def total_price
    books.map(&:price).sum
  end

  def book_titles
    books.map(&:title)
  end

  def find_books_by_author(author)
    find_author = -> (fa) {fa.author.eql? author}
    books.select(&find_author)
  end

  def cheapest_book
    min_price = -> (mp) {mp.price.eql? books.map(&:price).min}
    books.select(&min_price)
  end
end

class Book
  attr_reader :title, :author, :price

  def initialize(title, author, price)
    @title = title
    @author = author
    @price = price
  end
end

RSpec.describe Bookstore do
  let(:bookstore) { Bookstore.new }

  let(:book_1_title) { Faker::Book.title}
  let(:book_1_author) { Faker::Book.author}
  let(:book_1_price) {  Faker::Number.decimal(l_digits: 2)}

  let(:book_2_title) { Faker::Book.title}
  let(:book_2_author) { Faker::Book.author}
  let(:book_2_price) {  Faker::Number.decimal(l_digits: 2)}

  let(:book_3_title) { Faker::Book.title}
  let(:book_3_author) { Faker::Book.author}
  let(:book_3_price) {  Faker::Number.decimal(l_digits: 2)}

  describe "#add_book" do
    it "adds a book to the bookstore" do
      book = Book.new(book_1_title, book_1_author, book_1_price)
      bookstore.add_book(book)
      expect(bookstore.books).to include(book)
    end
  end

  describe "#total_price" do
    it "returns the total price of all books in the bookstore" do
      book1 = Book.new(book_1_title, book_1_author, book_1_price)
      book2 = Book.new(book_2_title, book_2_author, book_2_price)
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      expect(bookstore.total_price).to eq(book_1_price + book_2_price)
    end

    it "returns the total price as zero when no books is available" do
      expect(bookstore.total_price).to eq(0)
    end
  end

  describe "#book_titles" do
    it "returns an array of all book titles in the bookstore" do
      book1 = Book.new(book_1_title, book_1_author, book_1_price)
      book2 = Book.new(book_2_title, book_2_author, book_2_price)
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      expect(bookstore.book_titles).to eq([book_1_title, book_2_title])
    end

    it "returns an empty array when no books is available" do
      expect(bookstore.book_titles).to eq([])
    end
  end

  describe "#find_books_by_author" do
    it "returns an array of all books by a given author" do
      book1 = Book.new(book_1_title, book_1_author, book_1_price)
      book2 = Book.new(book_2_title, book_2_author, book_2_price)
      book3 = Book.new(book_3_title, book_3_author, book_3_price)
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      bookstore.add_book(book3)
      expect(bookstore.find_books_by_author(book_2_author)).to eq([book2])
    end

    it "returns an empty array when no books is available" do
      expect(bookstore.find_books_by_author("Ratan Tirkey")).to eq([])
    end
  end

  describe "#cheapest_book" do
    it "returns the cheapest book in the bookstore" do
      book1 = Book.new(book_1_title, book_1_author, book_1_price)
      book2 = Book.new(book_2_title, book_2_author, book_2_price)
      bookstore.add_book(book1)
      bookstore.add_book(book2)
      expect(bookstore.cheapest_book).to eq([book2])
    end

    it "returns an empty array when no books is available" do
      expect(bookstore.cheapest_book).to eq([])
    end
  end
end

RSpec.describe Book do
  let(:book_1_title) { Faker::Book.title}
  let(:book_1_author) { Faker::Book.author}
  let(:book_1_price) {  Faker::Number.decimal(l_digits: 2)}

  describe "#initialize" do
    it "sets the title, author, and price of the book" do
      book = Book.new(book_1_title, book_1_author, book_1_price)
      expect(book.title).to eq(book_1_title)
      expect(book.author).to eq(book_1_author)
      expect(book.price).to eq(book_1_price)
    end
  end
end
