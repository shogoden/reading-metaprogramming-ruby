# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method('//') do
    "//"
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
# - また、2で定義するメソッドは以下を満たすものとする
#   - メソッドが定義されるのは同時に生成されるオブジェクトのみで、別のA2インスタンスには（同じ値を含む配列を生成時に渡さない限り）定義されない
class A2
  def dev_team
    "SmartHR Dev Team"
  end

  def initialize(args)
    args.each do |arg|
      define_singleton_method("hoge_#{arg.to_s}") do |num|
        if num.nil?
          dev_team
        else
          "hoge_#{arg.to_s}" * num
        end
      end
    end
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること

# >OriginalAccessorモジュールはincludeされたとき
# 多分これ...？
# https://docs.ruby-lang.org/ja/latest/class/Module.html#I_INCLUDED
module OriginalAccessor
  def self.included(mod)
    mod.define_singleton_method('my_attr_accessor') do |arg|
      # my_attr_accessorはgetter/setterに加えて
      # 多分、それぞれのやつを定義すれば良さそう？
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end

      # なんでここ「=」ないとダメなのか分からん...
      define_method("#{arg}=") do |value|
        instance_variable_set("@#{arg}", value)

        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          define_singleton_method("#{arg}?") do
            value
          end
        end
      end
    end
  end
end