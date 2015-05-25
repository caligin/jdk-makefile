#alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_45/bin/jar 100
Dir.entries('/usr/lib/jvm/emaze-8/bin').each do |e|
 `update-alternatives --install /usr/bin/#{e} #{e} /usr/lib/jvm/emaze-8/bin/#{e} 100` unless e.start_with? '.'
 end

Dir.entries('/usr/lib/jvm/emaze-8/jre/bin').each do |e|
 `update-alternatives --install /usr/bin/#{e} #{e} /usr/lib/jvm/emaze-8/jre/bin/#{e} 100` unless e.start_with? '.'
 end
