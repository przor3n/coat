#!/bin/bash

function fill() {
	read -ep "$1" variable
	echo $variable
}
