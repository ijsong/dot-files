#!/usr/bin/env bash

function dkmadmin {
        if [[ $# -ne 3 ]]
        then
                echo "Usage: dkmadmin {rm|create} start_idx end_idx"
                return -1
        fi

        cmd=$1
        s=$2
        e=$3
        case $cmd in
                rm)
                        while [[ $s -le $e ]]
                        do
                                docker-machine rm -y vm$s
                                s=$((s+1))
                        done
                        ;;

                create)
                        while [[ $s -le $e ]]
                        do
                                docker-machine create --driver virtualbox vm$s
                                s=$((s+1))
                        done
                        ;;

                *)
                        echo "Usage: dkmadmin {rm|create} start_idx end_idx"
                        return -1
        esac

}

function dkm {
        docker-machine $@
}

function dkma {
        docker-machine $1 $(docker-machine ls -q)
}

function drm {
        docker rm $(docker ps -aq)
}

function dri {
        docker rmi $(docker image -q)
}

function drv {
        docker rm $(docker volume ls -q)

}
