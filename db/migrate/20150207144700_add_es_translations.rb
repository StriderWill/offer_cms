class AddEsTranslations < ActiveRecord::Migration
	def change
		add_column :offers, :es_title, :string
		add_column	:offers, :es_description, :text
		add_column :offers, :es_house_rules, :text 
	end
end