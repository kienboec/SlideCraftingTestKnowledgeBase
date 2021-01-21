@cls
@TITLE SlideCrafting (creating slides since 2020)
@SET KBFOLDER=%~dp0KnowledgeBase
@SET DISTFOLDER=%~dp0dist
@SET SCFOLDER=%~dp0Slidecrafting

cd %SCFOLDER%\PatchingUtils\CRLF2LFPatcher 
dotnet run %SCFOLDER%\run.sh %SCFOLDER%\slideCrafting.sh %SCFOLDER%\updateTemplate.sh %SCFOLDER%\watch.sh
cd %SCFOLDER%\..

docker stop slidecrafting-instance
docker rm   slidecrafting-instance

@mkdir %DISTFOLDER%
docker build -t slidecrafting-container:latest "%SCFOLDER%"
docker run --rm -ti --privileged --env-file env.default -v "%KBFOLDER%:/miktex/work/src:ro" -v "%DISTFOLDER%:/miktex/work/dist:rw" -p 8080:8080/tcp --name slidecrafting-instance slidecrafting-container