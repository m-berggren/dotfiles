function flatten_py
    # Find and move all .py files from subdirectories (excluding __init__.py, migrations, and .git)
    for file in (find . -mindepth 2 -name "*.py" -type f ! -name "__init__.py" ! -name "migrations.*.py" -not -path './.git/*')
        # Strip leading ./ and replace / with .
        set relpath (string replace -r '^\\./' '' $file)
        set target ./(string replace -a '/' '.' $relpath)

        if test -e $target
            set counter 1
            set base (string replace -r '\.py$' '' $target)
            while test -e "$base"_"$counter".py
                set counter (math $counter + 1)
            end
            set target "$base"_"$counter".py
        end

        mv $file $target
        echo "Moved: $file -> $target"
    end

    # Remove all files except .py and .toml in subdirectories (excluding .git)
    for file in (find . -mindepth 2 -type f ! -name "*.py" ! -name "*.toml" -not -path './.git/*')
        rm $file
        echo "Removed file: $file"
    end

    # Remove __init__.py files everywhere
    for file in (find . -name "__init__.py" -type f)
        rm $file
        echo "Removed: $file"
    end

    # Remove migrations.*.py files everywhere
    for file in (find . -name "migrations.*.py" -type f)
        rm $file
        echo "Removed migration: $file"
    end

    # Remove non-.py/.toml files in root directory (depth 1 only)
    for file in (find . -maxdepth 1 -type f ! -name "*.py" ! -name "*.toml")
        rm $file
        echo "Removed root file: $file"
    end

    # Remove .git directory
    if test -d .git
        rm -rf .git
        echo "Removed: .git"
    end

    # Remove all subdirectories (now empty)
    for dir in (find . -mindepth 1 -type d | sort -r)
        rmdir $dir 2>/dev/null
        and echo "Removed dir: $dir"
    end
end
