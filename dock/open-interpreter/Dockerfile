FROM python:3.12

RUN useradd -m appuser
ENV HOME=/home/appuser
RUN mkdir -p "$HOME/.config/open-interpreter/conversations" \
    && mkdir -p "$HOME/.config/open-interpreter/profiles" \
    && mkdir -p "$HOME/work" \
    && chown -R appuser:appuser "$HOME"
USER appuser
ENV PATH="$HOME/.local/bin:${PATH}"
WORKDIR $HOME
RUN pip install git+https://github.com/OpenInterpreter/open-interpreter.git
COPY ./default.yaml $HOME/.config/open-interpreter/profiles/default.yaml
