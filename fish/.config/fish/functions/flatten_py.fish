function flatten_py
    for file in (find . -mindepth 2 \( -name "*.py" -o -name "*.html" -o -name "*.js" \) -type f ! -name "__init__.py" ! -name "*.migrations.*.py" -not -path './.git/*')
        set relpath (string replace -r '^\\./' '' $file)
        set target ./(string replace -a '/' '.' $relpath)

        if test -e $target
            set counter 1
            set base (string replace -r '\.[^.]+$' '' $target)
            while test -e "$base"_"$counter".(string match -r '\.[^.]+$' $target | string replace '.' '')
                set counter (math $counter + 1)
            end
            set target "$base"_"$counter".(string match -r '[^.]+$' $file)
        end

        mv $file $target
        echo "Moved: $file -> $target"
    end

    for file in (find . -mindepth 2 -type f ! -name "*.py" ! -name "*.html" ! -name "*.js" ! -name "*.toml" -not -path './.git/*')
        rm $file
        echo "Removed file: $file"
    end

    for file in (find . -name "__init__.py" -type f)
        rm $file
        echo "Removed: $file"
    end

    for file in (find . -name "migrations.*.py" -type f)
        rm $file
        echo "Removed migration: $file"
    end

    for file in (find . -maxdepth 1 -type f ! -name "*.py" ! -name "*.html" ! -name "*.js" ! -name "*.toml")
        rm $file
        echo "Removed root file: $file"
    end

    if test -d .git
        rm -rf .git
        echo "Removed: .git"
    end

    for dir in (find . -mindepth 1 -type d | sort -r)
        rmdir $dir 2>/dev/null
        and echo "Removed dir: $dir"
    end
end
