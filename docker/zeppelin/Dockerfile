FROM apache/zeppelin:0.7.3

MAINTAINER Luis Eduardo Ferro Diez <lferrod@psl.com.co>

RUN apt-get update -y && apt-get install -y nano

RUN pip install pandas geopandas matplotlib scikit-learn

COPY ./assets/shiro.ini /zeppelin/conf/shiro.ini

COPY ./assets/zeppelin-site.xml /zeppelin/conf/zeppelin-site.xml

COPY ./assets/zeppelin-env.sh /zeppelin/conf/zeppelin-env.sh
