.PHONY: env

VENV    ?= .venv
PIP     ?= $(VENV)/bin/pip
PYTHON  ?= python3

ROBOT   ?= $(VENV)/bin/robot

all: env robo

env:
ifeq ($(wildcard $(PIP)),)
	$(PYTHON) -m venv $(VENV)
endif
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt

robo:
	$(ROBOT) --skiponfailure Known --outputdir output tests