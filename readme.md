# Docker Image for building [Kodi](https://github.com/xbmc/xbmc)

This a is Docker image for building Kodi based on Ubuntu. It is useful if you are working on
Kodi and don't want to litter your OS with Kodi build dependencies.

## Requirements

* [Docker](https://docs.docker.com/engine/install/) >= 19.03

## Building Kodi

### Prepare Docker image

```sh
docker build -t kodi-docker-build .
```

### Link source code

Create a symlink to your Kodi source:

```sh
ln -s <path_to_kodi_source> xbmc
```

> If you just want to build the current `master`-branch, simply execute
  `git clone https://github.com/xbmc/xbmc.git`.

### Build Kodi inside Docker

> The build will take up a lot of memory, so make sure to limit it accordingly.   
> If you run into memory issues, adapt `build.sh` to only use one job (`-j1`).

```sh
docker run \
  --memory "8g" \
  --memory-swap "8g" \
  --volume $(readlink -f xbmc):/kodi/source \
  --volume $(pwd)/build:/kodi/build \
  kodi-docker-build:latest build.sh
```

The first build will take a few hours.

## Testing the build

You should find a `kodi-x11` file in the `build` folder.

Execute it to test your build. If it does not work because
of missing libraries, install Kodi via `apt`:

```sh
sudo add-apt-repository ppa:team-xbmc/xbmc-nightly
sudo apt-get update
sudo apt-get install kodi
```

This will install all missing dependencies.

## Clean up

Run `sudo git clean -xdf` to clean the `build` folder.

## Copyright and license

Licensed under the MIT License - see `LICENSE` for details.