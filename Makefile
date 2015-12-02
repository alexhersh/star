all: star-probe star-collect

clean:
	cargo clean

test:
	cargo test

star-probe:
	cargo build --bin star-probe
	cp target/debug/star-probe ./probe

star-collect:
	cargo build --bin star-collect
	cp target/debug/star-collect ./collect

probe-image: star-probe 
	docker build -t alexhersh/probe ./probe

collect-image: star-collect
	docker build -t alexhersh/collect ./collect

dockerhub: probe-image collect-image
	docker push alexhersh/probe
	docker push alexhersh/collect

tar: probe-image collect-image 
	docker save alexhersh/probe > probe.tar
	docker save alexhersh/collect > collect.tar
