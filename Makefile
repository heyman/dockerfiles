.PHONY: redis postgresql memcached elasticsearch

postgresql redis memcached elasticsearch:
	cp ~/.ssh/id_rsa.pub ./$@/id_rsa.pub
	docker build -t heyman/$@ $@/
	rm ./$@/id_rsa.pub
