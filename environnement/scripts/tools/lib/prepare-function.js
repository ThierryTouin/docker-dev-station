function prepareFunctionTab(composeFiles, config) {
    const { COMMAND, COMPOSE_COMMAND } = config;

    const functionMap = new Map();
    const functionNameTab = [];
  
    composeFiles.forEach(({ path: filePath, dirname, basename, ecmdMeta }) => {
      const tag = ecmdMeta.tag || "defaultTag";
  
      if (!functionMap.has(tag)) {
        functionMap.set(tag, []);
      }
      functionMap.get(tag).push({ dirname, basename, ecmdMeta });
    });
  
    let functionIndexMap = new Map();
    functionMap.forEach((files, tag) => {
      files.forEach(({ dirname, basename, ecmdMeta }, index) => {
        if (!functionIndexMap.has(tag)) {
          functionIndexMap.set(tag, 1);
        }
        const functionName = files.length > 1 ? `${tag}${functionIndexMap.get(tag)}` : tag;
        functionIndexMap.set(tag, functionIndexMap.get(tag) + 1);

        functionNameTab.push({ functionName, ecmdMeta, dirname, basename });
    });
  });

  return functionNameTab;

}
  
module.exports = { prepareFunctionTab };