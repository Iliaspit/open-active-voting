# Copyright (C) 2010-2013 Íbúar ses
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class BudgetConfig < ActiveRecord::Base
  set_table_name "config"

  validates :there_can_only_be_one

  def self.current
    unless Rails.env.production?
      unless BudgetConfig.first
        config=BudgetConfig.new
        config.timeout_in_seconds = 20
        config.rsk_url = "https://www.island.is/audkenning?id=ktest.betrireykjavik.is"
        config.save
      end
    end
    BudgetConfig.first
  end

  private

  def there_can_only_be_one
    errors.add_to_base('There can only be one') if BudgetConfig.count > 0
  end

end
