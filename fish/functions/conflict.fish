function conflict
	git diff --name-only | uniq | xargs nvim
end
