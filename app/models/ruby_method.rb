# frozen_string_literal: true

class RubyMethod < ApplicationRecord
  has_many :user_ruby_methods, dependent: :destroy
  belongs_to :ruby_module

  validates :name, presence: true, uniqueness: { scope: :ruby_module_id }
  validates :official_url, presence: true

  def self.unchallenged_ruby_method(ruby_methods, challenged_ruby_methods)
    (ruby_methods - challenged_ruby_methods).sample
  end

  def register_method_url(ruby_method, module_name, ruby_method_name)
    if Net::HTTP.get_response(URI.parse("https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{ruby_method_name}.html")).code == '200'
      ruby_method.official_url = "https://docs.ruby-lang.org/ja/latest/method/#{module_name}/i/#{ruby_method_name}.html"
    else
      ruby_method.official_url = "https://docs.ruby-lang.org/ja/latest/class/#{module_name}.html#I_#{ruby_method_name.upcase.slice(/[^?]+/)}--3F"
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(auth_object = nil)
    ['ruby_module']
  end
end
