function cleaner_help()
    path = get_absolute_file_path("cleaner_help.sce");
    langdirs = dir(path);
    langdirs = langdirs.name(langdirs.isdir);

    for l = 1:size(langdirs, "*")
        masterfile = fullpath(path + filesep() + langdirs(l) + "/master_help.xml");
        mdelete(masterfile);

        jarfile = fullpath(path + "/../jar/scilab_" + langdirs(l) + "_help.jar");
        mdelete(jarfile);

        tmphtmldir = fullpath(path + "/" + langdirs(l) + "/scilab_" + langdirs(l) + "_help");
        rmdir(tmphtmldir, "s");

        for funcname = macros_to_document
            xmlhelpfile = fullpath(path + "/" + langdirs(l) + "/" + funcname + ".xml");
            mdelete(xmlhelpfile);
        end
    end
    rmdir("jar");
endfunction

exec("help" + filesep() + "macros_to_document.sce");
cleaner_help();
clear cleaner_help macros_to_document
