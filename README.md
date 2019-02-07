# ryo-full-node

docker image to run a ryo full network node

# attributions

This is adapted from https://github.com/kannix/monero-full-node

# Usage

**first start:**  
you need to change the permission of the mounted volume to allow the monero user inside the container to write the blockain in the volume. To do this, you have to mount the volume where you want to store the blockchain to the container and chown that path to the ryo user. e.g.

`docker run -v /data/ryo:/home/ryo/.ryo -t --rm --name=ryod -u root --entrypoint=/bin/chown stubdal/ryo-full-node -R ryo:ryo .ryo`

you have to do this only once before first start.

After this, you can start the container with e.g.

`docker run -d --name ryod --restart=unless-stopped -v /data/ryo:/home/ryo/.ryo -p 12210:12210 -p 12211:12211 stubdal/ryo-full-node`

## Updates
Manual Way
```
docker stop ryod
docker rm ryod
docker pull stubdal/ryo-full-node
```
Then launch using the "how to use" command above

Automatic way
https://github.com/v2tec/watchtower

# Donations

I don't accept donations, but if you find this useful, you can donate the author of the original version I adapted it from here:
https://github.com/kannix/monero-full-node#Donations
