class Country
  attr_accessor :id, :country, :population, :gdp

  def self.open_connection
    conn = PG.connect(dbname: "tech-a48")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM country ORDER BY id"

    result = conn.exec(sql)

    countrys = result.map do |result|
      self.hydrate(result)
    end

    countrys
  end

  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM country WHERE id = #{id}"

    result = conn.exec(sql)

    countrys = result.map do |result|
      self.hydrate(result)
    end

    countrys[0]
  end

  def save
    conn = Country.open_connection
    if (!self.id)
      sql = "INSERT INTO country (country, population, gdp) VALUES ('#{self.country}', '#{self.population}', '#{self.gdp}')"
    else
      sql = "UPDATE country SET country='#{self.country}', population='#{self.population}', gdp='#{self.gdp}' WHERE id=#{self.id}"
    end
    conn.exec(sql)
  end

  def destroy id
    conn = Country.open_connection

    sql = "DELETE FROM country WHERE id = #{id}"

    conn.exec(sql)
  end

  def self.hydrate post_data
    country = Country.new

    country.id = post_data['id']
    country.country = post_data['country']
    country.population = post_data['population']
    country.gdp = post_data['gdp']

    country
  end

end
