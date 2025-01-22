function generateEcmdUI(functionTab) {

    let output = '';
    let sep = '';
    functionTab.forEach(({ functionName, ecmdMeta, dirname, basename }) => {
        output += `${sep}`;
        output += `700,${functionName},http://localhost:${ecmdMeta.port}`;
        sep = ';';
    });

    return output;
}

module.exports = { generateEcmdUI };


