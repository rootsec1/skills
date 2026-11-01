SKILLS := npx --yes skills@1.7.4
INSTALL_FLAGS := --global --agent '*' --yes
CUSTOM_SOURCE := ./skills

.DEFAULT_GOAL := install
.NOTPARALLEL:
.PHONY: install install-custom install-upstream

install: install-custom install-upstream

install-custom:
	$(SKILLS) add "$(CUSTOM_SOURCE)" $(INSTALL_FLAGS) --skill '*'

install-upstream:
	$(SKILLS) add vercel-labs/agent-browser $(INSTALL_FLAGS) --skill agent-browser
	$(SKILLS) add vercel-labs/skills $(INSTALL_FLAGS) --skill find-skills
	$(SKILLS) add pbakaus/impeccable $(INSTALL_FLAGS) --skill impeccable
	$(SKILLS) add dietrichgebert/ponytail $(INSTALL_FLAGS) --skill ponytail
	$(SKILLS) add shadcn-ui/ui $(INSTALL_FLAGS) --skill shadcn
	$(SKILLS) add vercel/turborepo $(INSTALL_FLAGS) --skill turborepo
	$(SKILLS) add https://github.com/cursor/plugins/tree/main/pstack/skills/unslop $(INSTALL_FLAGS) --skill unslop
	$(SKILLS) add railwayapp/railway-skills $(INSTALL_FLAGS) --skill use-railway
	$(SKILLS) add vercel-labs/agent-skills $(INSTALL_FLAGS) --skill vercel-react-best-practices
