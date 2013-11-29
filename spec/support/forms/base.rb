module Form
  class Base
    include Capybara::DSL

    private

    def ids_of(items)
      items.map do |item|
        item.id
      end.join ','
    end
  end
end
