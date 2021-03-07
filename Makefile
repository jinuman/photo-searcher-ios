app:
	make generate
	make cocoapods

cocoapods:
	@echo "Make Pods"
	@bundle exec pod binary prebuild || bundle exec pod binary prebuild --repo-update

generate:
	@echo "Generate project"
	@tuist generate || tuist generate --project-only