.PHONY: redis postgresql memcached

postgresql redis memcached:
	cp ~/.ssh/id_rsa.pub ./$@/id_rsa.pub
	docker build -t heyman/$@ $@/
	rm ./$@/id_rsa.pub
