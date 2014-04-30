module ApplicationHelper
  def auth_token
    return <<-HTML.html_safe
      <input type="hidden" name="authenticity_token" value="#{ form_authenticity_token }">
    HTML
  end

  def data_for_transaction_categories(transactions)
    data = Hash.new { |h, k| h[k] = 0 }
    
    transactions.each do |transaction|
      data[transaction.transaction_category.description] += 1
    end

    data.to_a
    # fail
  end

  def urls_for_transaction_categories
    urls = {}

    TransactionCategory.all.each do |category|
      urls[category.description] = transaction_category_url(category)
    end

    urls
  end

  def ids_for_account_transaction_categories
    urls = {}

    TransactionCategory.all.each do |category|
      urls[category.description] = category.id
    end

    urls
  end
end
