function calculadoraSoma()
    % Cria uma figura
    f = figure('Name', 'Calculadora de Soma', 'NumberTitle', 'off');

    % Cria caixas de texto para entrada de números
    uicontrol('Style', 'text', 'String', 'Número 1:', 'Position', [20, 60, 80, 20]);
    num1_edit = uicontrol('Style', 'edit', 'Position', [120, 60, 100, 20]);

    uicontrol('Style', 'text', 'String', 'Número 2:', 'Position', [20, 30, 80, 20]);
    num2_edit = uicontrol('Style', 'edit', 'Position', [120, 30, 100, 20]);

    % Cria um botão para calcular a soma
    calcular_button = uicontrol('Style', 'pushbutton', 'String', 'Calcular Soma', 'Position', [20, 5, 200, 20], 'Callback', @calcularSoma);

    % Função para calcular a soma
    function calcularSoma(~, ~)
        num1 = str2double(get(num1_edit, 'String'));
        num2 = str2double(get(num2_edit, 'String'));

        if isnan(num1) || isnan(num2)
            msgbox('Por favor, insira números válidos.', 'Erro', 'error');
        else
            soma = num1 + num2;
            msgbox(['A soma de ' num2str(num1) ' e ' num2str(num2) ' é ' num2str(soma)], 'Resultado');
        end
    end
end

% Chama a função da calculadora
calculadoraSoma();
