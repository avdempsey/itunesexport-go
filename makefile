buildnumber := DEV
ifdef BUILD_NUMBER
	buildnumber := ${BUILD_NUMBER}
endif

all: build

build:
	go get -v
	go build -v -ldflags "-X main.Version $(buildnumber)"

package: build
	rm -Rf output
	mkdir output
	mv itunesexport-go output/itunesexport
	GOOS=windows GOARCH=386 go build -v -ldflags "-X main.Version $(buildnumber)"
	mv itunesexport-go.exe output/itunesexport.exe
	GOOS=windows GOARCH=amd64 go build -v -ldflags "-X main.Version $(buildnumber)"
	mv itunesexport-go.exe output/itunesexport64.exe
	
clean:
	rm -Rf itunesexport-go
	rm -Rf output

run: build
	./itunesexport-go
