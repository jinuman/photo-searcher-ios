project:
	make cocoapods
	make tuist

cocoapods:
	@echo "Making cocoapods dependencies"
	@bundle exec pod binary prebuild || bundle exec pod binary prebuild --repo-update

tuist:
	@echo "Construct project"
	@tuist generate || tuist generate --project-only