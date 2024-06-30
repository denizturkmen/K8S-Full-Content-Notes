demo/ Chart.yaml          # Chart hakkında bilgileri içeren bir yaml dosyası. 
LICENSE                   # Chart lisansını içeren dosya (opsiyonel) 
README.md                 # Chart kullanımı veya farklı bilgiler için readme dosyası. (opsiyonel) 
values.yaml               # Kubernetes kaynaklarımıza doğrudan erişmek için oluşturduğumuz değişkenlerin tutulduğu dosya. values.schema.json  # value.yaml dosyasına bir yapı empoze etmek için json şeması (opsiyonel) 
charts/                   # Chartın içerisinde farklı chartları kullanabilmek için veya bağımlılıkları kullanabilmek için oluşturulan dizin. (kullanım opsiyonel) crds/          # Kubernetes Custom Resource Definitions 
templates/                # Kubernetes kaynaklarımızın bulunduğu dizin. 
templates/NOTES.txt       # Kubernetes kaynaklarımız deploy olduktan sonra terminal üzerinden kullanım hakkında veya farklı bilgiler göstermek için kullanılabilir.(opsiyonel)
