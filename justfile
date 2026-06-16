set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

default:
  @just --list

gen-example:
    & 'C:\Program Files\OpenSCAD\openscad.com' -o example.png --view axes --imgsize 900,1000 -D is_prod=true example.scad