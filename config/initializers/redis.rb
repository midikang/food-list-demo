require 'redis/connection/hiredis'

# I18N_LOCALES = YAML.load_file(Rails.root.join('config', 'locales.yml'))['locales']

# module I18n
#   module Backend
#     class KeyValue
# 	 # 设定了合法的 locales
#       def available_locales
#         a = []
#         I18N_LOCALES.each do |lang, countries|
#           countries.each do |c|
#             a << "#{lang}-#{c}"
#           end
#         end
#         a
#       end
#     end
#   end
# end

$i18n_redis = Redis.new(YAML.load_file("#{Rails.root}/config/redis.yml")['i18n'])
# I18n.backend = I18n::Backend::CachedKeyValueStore.new($i18n_redis)
I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new($i18n_redis), I18n.backend)
